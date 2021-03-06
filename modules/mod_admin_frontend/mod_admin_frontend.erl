%% @author Marc Worrell <marc@worrell.nl>
%% @copyright 2013 Marc Worrell
%% @doc Administrative interface version for use via a web site's frontend.

%% Copyright 2013 Marc Worrell
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(mod_admin_frontend).

-author("Marc Worrell <marc@worrell.nl>").

-mod_title("Admin Frontend").
-mod_description("Edit pages on a web site; subset of admin module for Bootstrap based web sites.").
-mod_depends([mod_admin]).

-export([
	event/2
	]).

-include("zotonic.hrl").

event(#postback{message='admin-menu-edit'}, Context) ->
	case m_rsc:rid(z_context:get_q("id", Context), Context) of
		undefined ->
			Context;
		Id ->
			Context1 = z_render:update("editcol", #render{template={cat, "_admin_frontend_edit.tpl"}, vars=[{id,Id}]}, Context),
			z_script:add_script(<<"setTimeout(function() { z_tinymce_init(); }, 100);">>, Context1)
	end.
