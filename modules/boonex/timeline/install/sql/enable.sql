-- PAGES & BLOCKS
INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_timeline_view', '_bx_timeline_page_title_sys_view', '_bx_timeline_page_title_view', 'bx_timeline', 5, 2147483647, 1, 'timeline-view', 'page.php?i=timeline-view', '', '', '', 0, 1, 0, 'BxTimelinePageView', 'modules/boonex/timeline/classes/BxTimelinePageView.php'),
('bx_timeline_view_home', '_bx_timeline_page_title_sys_view_home', '_bx_timeline_page_title_view_home', 'bx_timeline', 5, 2147483647, 1, 'timeline-view-home', 'page.php?i=timeline-view-home', '', '', '', 0, 1, 0, '', ''),
('bx_timeline_item', '_bx_timeline_page_title_sys_item', '_bx_timeline_page_title_item', 'bx_timeline', 5, 2147483647, 1, 'timeline-item', 'page.php?i=timeline-item', '', '', '', 0, 1, 0, '', '');

INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('bx_timeline_view', 1, 'bx_timeline', '_bx_timeline_page_block_title_system_post_profile', '_bx_timeline_page_block_title_post_profile', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:14:"get_block_post";}', 0, 0, 1, 1),
('bx_timeline_view', 1, 'bx_timeline', '_bx_timeline_page_block_title_system_view_profile', '_bx_timeline_page_block_title_view_profile', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:14:"get_block_view";}', 0, 0, 1, 2),
('bx_timeline_view', 1, 'bx_timeline', '_bx_timeline_page_block_title_system_view_profile_outline', '_bx_timeline_page_block_title_view_profile_outline', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:22:"get_block_view_outline";}', 0, 0, 0, 3),

('bx_timeline_view_home', 1, 'bx_timeline', '_bx_timeline_page_block_title_system_post_home', '_bx_timeline_page_block_title_post_home', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:19:"get_block_post_home";}', 0, 0, 1, 1),
('bx_timeline_view_home', 1, 'bx_timeline', '_bx_timeline_page_block_title_system_view_home', '_bx_timeline_page_block_title_view_home', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:19:"get_block_view_home";}', 0, 0, 0, 2),
('bx_timeline_view_home', 1, 'bx_timeline', '_bx_timeline_page_block_title_system_view_home_outline', '_bx_timeline_page_block_title_view_home_outline', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:27:"get_block_view_home_outline";}', 0, 0, 1, 3),

('bx_timeline_item', 1, 'bx_timeline', '', '_bx_timeline_page_block_title_item', 0, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:14:"get_block_item";}', 0, 0, 1, 1);

-- PAGES: add page block on dashboard
SET @iPBCellDashboard = 2;
SET @iPBOrderDashboard = 1; --(SELECT IFNULL(MAX(`order`), 0) FROM `sys_pages_blocks` WHERE `object` = 'sys_dashboard' AND `cell_id` = @iPBCellDashboard LIMIT 1);
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('sys_dashboard', @iPBCellDashboard, 'bx_timeline', '_bx_timeline_page_block_title_system_post_account', '_bx_timeline_page_block_title_post_account', 11, 2147483644, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:22:"get_block_post_account";}', 0, 1, 1, @iPBOrderDashboard),
('sys_dashboard', @iPBCellDashboard, 'bx_timeline', '_bx_timeline_page_block_title_system_view_account', '_bx_timeline_page_block_title_view_account', 11, 2147483644, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:22:"get_block_view_account";}', 0, 1, 1, @iPBOrderDashboard + 1),
('sys_dashboard', @iPBCellDashboard, 'bx_timeline', '_bx_timeline_page_block_title_system_view_account_outline', '_bx_timeline_page_block_title_view_account_outline', 11, 2147483644, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:30:"get_block_view_account_outline";}', 0, 1, 0, @iPBOrderDashboard + 1);

-- PAGES: add page block on home
SET @iPBCellHome = 1;
SET @iPBOrderHome = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_pages_blocks` WHERE `object` = 'sys_home' AND `cell_id` = @iPBCellHome ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('sys_home', @iPBCellHome, 'bx_timeline', '_bx_timeline_page_block_title_system_post_home', '_bx_timeline_page_block_title_post_home', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:19:"get_block_post_home";}', 0, 1, 1, @iPBOrderHome + 1),
('sys_home', @iPBCellHome, 'bx_timeline', '_bx_timeline_page_block_title_system_view_home', '_bx_timeline_page_block_title_view_home', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:19:"get_block_view_home";}', 0, 1, 0, @iPBOrderHome + 2),
('sys_home', @iPBCellHome, 'bx_timeline', '_bx_timeline_page_block_title_system_view_home_outline', '_bx_timeline_page_block_title_view_home_outline', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:27:"get_block_view_home_outline";}', 0, 1, 1, @iPBOrderHome + 3);

-- PAGES: add page block to profiles modules (trigger* page objects are processed separately upon modules enable/disable)
SET @iPBCellProfile = 2;
SET @iPBCellGroup = 4;
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('trigger_page_profile_view_entry', @iPBCellProfile, 'bx_timeline', '_bx_timeline_page_block_title_system_post_profile', '_bx_timeline_page_block_title_post_profile', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:22:"get_block_post_profile";s:6:"params";a:1:{i:0;s:6:"{type}";}}', 0, 0, 1, 0),
('trigger_page_profile_view_entry', @iPBCellProfile, 'bx_timeline', '_bx_timeline_page_block_title_system_view_profile', '_bx_timeline_page_block_title_view_profile', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:22:"get_block_view_profile";s:6:"params";a:1:{i:0;s:6:"{type}";}}', 0, 0, 1, 0),
('trigger_page_profile_view_entry', @iPBCellProfile, 'bx_timeline', '_bx_timeline_page_block_title_system_view_profile_outline', '_bx_timeline_page_block_title_view_profile_outline', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:30:"get_block_view_profile_outline";s:6:"params";a:1:{i:0;s:6:"{type}";}}', 0, 0, 0, 0),

('trigger_page_group_view_entry', @iPBCellGroup, 'bx_timeline', '_bx_timeline_page_block_title_system_post_profile', '_bx_timeline_page_block_title_post_profile', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:22:"get_block_post_profile";s:6:"params";a:1:{i:0;s:6:"{type}";}}', 0, 0, 1, 0),
('trigger_page_group_view_entry', @iPBCellGroup, 'bx_timeline', '_bx_timeline_page_block_title_system_view_profile', '_bx_timeline_page_block_title_view_profile', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:22:"get_block_view_profile";s:6:"params";a:1:{i:0;s:6:"{type}";}}', 0, 0, 1, 0),
('trigger_page_group_view_entry', @iPBCellGroup, 'bx_timeline', '_bx_timeline_page_block_title_system_view_profile_outline', '_bx_timeline_page_block_title_view_profile_outline', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:30:"get_block_view_profile_outline";s:6:"params";a:1:{i:0;s:6:"{type}";}}', 0, 0, 0, 0);


-- MENU: Item Share (Repost, Send to Friend, etc)
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_timeline_menu_item_share', '_bx_timeline_menu_title_item_share', 'bx_timeline_menu_item_share', 'bx_timeline', 6, 0, 1, 'BxTimelineMenuItemShare', 'modules/boonex/timeline/classes/BxTimelineMenuItemShare.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_timeline_menu_item_share', 'bx_timeline', '_bx_timeline_menu_set_title_item_share', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('bx_timeline_menu_item_share', 'bx_timeline', 'item-repost', '_bx_timeline_menu_item_title_system_item_repost', '_bx_timeline_menu_item_title_item_repost', 'javascript:void(0)', 'javascript:{js_onclick_repost}', '_self', 'repeat', '', 2147483647, 1, 0, 1),
('bx_timeline_menu_item_share', 'bx_timeline', 'item-send', '_bx_timeline_menu_item_title_system_item_send', '_bx_timeline_menu_item_title_item_send', 'page.php?i=start-convo&et={et_send}', '', '_self', 'envelope', '', 2147483647, 1, 0, 2);

-- MENU: Item Manage (Pin, Delete, etc)
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_timeline_menu_item_manage', '_bx_timeline_menu_title_item_manage', 'bx_timeline_menu_item_manage', 'bx_timeline', 6, 0, 1, 'BxTimelineMenuItemManage', 'modules/boonex/timeline/classes/BxTimelineMenuItemManage.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_timeline_menu_item_manage', 'bx_timeline', '_bx_timeline_menu_set_title_item_manage', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_timeline_menu_item_manage', 'bx_timeline', 'item-pin', '_bx_timeline_menu_item_title_system_item_pin', '_bx_timeline_menu_item_title_item_pin', 'javascript:void(0)', 'javascript:{js_object_view}.pinPost(this, {content_id}, 1)', '_self', 'thumb-tack', '', 2147483647, 1, 0, 0),
('bx_timeline_menu_item_manage', 'bx_timeline', 'item-unpin', '_bx_timeline_menu_item_title_system_item_unpin', '_bx_timeline_menu_item_title_item_unpin', 'javascript:void(0)', 'javascript:{js_object_view}.pinPost(this, {content_id}, 0)', '_self', 'thumb-tack', '', 2147483647, 1, 0, 1),
('bx_timeline_menu_item_manage', 'bx_timeline', 'item-delete', '_bx_timeline_menu_item_title_system_item_delete', '_bx_timeline_menu_item_title_item_delete', 'javascript:void(0)', 'javascript:{js_object_view}.deletePost(this, {content_id})', '_self', 'remove', '', 2147483647, 1, 0, 2);

-- MENU: Item Actions (Comment, Vote, Share, Report, etc)
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_timeline_menu_item_actions', '_bx_timeline_menu_title_item_actions', 'bx_timeline_menu_item_actions', 'bx_timeline', 15, 0, 1, 'BxTimelineMenuItemActions', 'modules/boonex/timeline/classes/BxTimelineMenuItemActions.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_timeline_menu_item_actions', 'bx_timeline', '_bx_timeline_menu_set_title_item_actions', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `active`, `copyable`, `editable`, `order`) VALUES
('bx_timeline_menu_item_actions', 'bx_timeline', 'item-view', '_bx_timeline_menu_item_title_system_item_view', '', 'javascript:void(0)', '', '', '', '', '', 0, 2147483647, 0, 0, 1, 0),
('bx_timeline_menu_item_actions', 'bx_timeline', 'item-comment', '_bx_timeline_menu_item_title_system_item_comment', '_bx_timeline_menu_item_title_item_comment', 'javascript:void(0)', 'javascript:{comment_onclick}', '_self', 'comment', 'a:3:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:27:"get_menu_item_addon_comment";s:6:"params";a:3:{i:0;s:16:"{comment_system}";i:1;s:16:"{comment_object}";i:2;s:6:"{view}";}}', '', 0, 2147483647, 1, 0, 1, 1),
('bx_timeline_menu_item_actions', 'bx_timeline', 'item-vote', '_bx_timeline_menu_item_title_system_item_vote', '', 'javascript:void(0)', '', '', '', '', '', 0, 2147483647, 1, 0, 1, 2),
('bx_timeline_menu_item_actions', 'bx_timeline', 'item-share', '_bx_timeline_menu_item_title_system_item_share', '', 'javascript:void(0)', 'bx_menu_popup(''bx_timeline_menu_item_share'', this, {''id'':''bx_timeline_menu_item_share_{content_id}''}, {content_id:{content_id}});', '', 'share-alt', '', 'bx_timeline_menu_item_share', 1, 2147483647, 1, 0, 1, 3),
('bx_timeline_menu_item_actions', 'bx_timeline', 'item-report', '_bx_timeline_menu_item_title_system_item_report', '', 'javascript:void(0)', '', '', '', '', '', 0, 2147483647, 1, 0, 1, 4),
('bx_timeline_menu_item_actions', 'bx_timeline', 'item-more', '_bx_timeline_menu_item_title_system_item_more', '', 'javascript:void(0)', 'bx_menu_popup(''bx_timeline_menu_item_manage'', this, {''id'':''bx_timeline_menu_item_manage_{content_id}''}, {content_id:{content_id}});', '', 'ellipsis-h', '', 'bx_timeline_menu_item_manage', 1, 2147483647, 1, 0, 1, 5);

-- MENU: Post form attachments (Link, Photo, Video)
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_timeline_menu_post_attachments', '_bx_timeline_menu_title_post_attachments', 'bx_timeline_menu_post_attachments', 'bx_timeline', 9, 0, 1, '', '');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_timeline_menu_post_attachments', 'bx_timeline', '_bx_timeline_menu_set_title_post_attachments', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `editable`, `order`) VALUES 
('bx_timeline_menu_post_attachments', 'bx_timeline', 'add-link', '_bx_timeline_menu_item_title_system_add_link', '_bx_timeline_menu_item_title_add_link', 'javascript:void(0)', 'javascript:{js_object}.showAttachLink(this);', '_self', 'link', '', '', 2147483647, 1, 0, 1, 1),
('bx_timeline_menu_post_attachments', 'bx_timeline', 'add-photo', '_bx_timeline_menu_item_title_system_add_photo', '_bx_timeline_menu_item_title_add_photo', 'javascript:void(0)', 'javascript:{js_object_uploader_photo}.showUploaderForm();', '_self', 'camera', '', '', 2147483647, 1, 0, 1, 2),
('bx_timeline_menu_post_attachments', 'bx_timeline', 'add-video', '_bx_timeline_menu_item_title_system_add_video', '_bx_timeline_menu_item_title_add_video', 'javascript:void(0)', 'javascript:{js_object_uploader_video}.showUploaderForm();', '_self', 'video-camera', '', '', 2147483647, 1, 0, 1, 3);

-- MENU: add to "add content" menu
SET @iAddMenuOrder = (SELECT `order` FROM `sys_menu_items` WHERE `set_name` = 'sys_add_content_links' AND `active` = 1 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_add_content_links', 'bx_timeline', 'create-post', '_bx_timeline_menu_item_title_system_create_entry', '_bx_timeline_menu_item_title_create_entry', 'page.php?i=timeline-view', '', '', 'clock-o col-green1', '', 2147483647, 1, 1, IFNULL(@iAddMenuOrder, 0) + 1);

-- MENU: add menu item to profiles modules (trigger* menu sets are processed separately upon modules enable/disable)
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('trigger_profile_view_submenu', 'bx_timeline', 'timeline-view', '_bx_timeline_menu_item_title_system_view_timeline_view', '_bx_timeline_menu_item_title_view_timeline_view', 'page.php?i=timeline-view&profile_id={profile_id}', '', '', 'clock-o col-green1', '', 2147483647, 1, 0, 0),
('trigger_group_view_submenu', 'bx_timeline', 'timeline-view', '_bx_timeline_menu_item_title_system_view_timeline_view', '_bx_timeline_menu_item_title_view_timeline_view', 'page.php?i=timeline-view&profile_id={profile_id}', '', '', 'clock-o col-green1', '', 2147483647, 1, 0, 0);


-- SETTINGS
SET @iTypeOrder = (SELECT MAX(`order`) FROM `sys_options_types` WHERE `group` = 'modules');
INSERT INTO `sys_options_types`(`group`, `name`, `caption`, `icon`, `order`) VALUES 
('modules', 'bx_timeline', '_bx_timeline', 'bx_timeline@modules/boonex/timeline/|std-icon.svg', IF(ISNULL(@iTypeOrder), 1, @iTypeOrder + 1));
SET @iTypeId = LAST_INSERT_ID();

INSERT INTO `sys_options_categories` (`type_id`, `name`, `caption`, `order`)
VALUES (@iTypeId, 'bx_timeline', '_bx_timeline', 1);
SET @iCategId = LAST_INSERT_ID();

INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `check`, `check_params`, `check_error`, `extra`, `order`) VALUES
('bx_timeline_enable_delete', 'on', @iCategId, '_bx_timeline_option_enable_delete', 'checkbox', '', '', '', '', 1),
('bx_timeline_events_per_page_profile', '10', @iCategId, '_bx_timeline_option_events_per_page_profile', 'digit', '', '', '', '', 2),
('bx_timeline_events_per_page_account', '20', @iCategId, '_bx_timeline_option_events_per_page_account', 'digit', '', '', '', '', 3),
('bx_timeline_events_per_page_home', '20', @iCategId, '_bx_timeline_option_events_per_page_home', 'digit', '', '', '', '', 4),
('bx_timeline_events_per_page', '20', @iCategId, '_bx_timeline_option_events_per_page', 'digit', '', '', '', '', 5),
('bx_timeline_rss_length', '5', @iCategId, '_bx_timeline_option_rss_length', 'digit', '', '', '', '', 6),
('bx_timeline_events_hide', '', @iCategId, '_bx_timeline_option_events_hide', 'rlist', '', '', '', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:21:"get_actions_checklist";}', 7),
('bx_timeline_chars_display_max', '300', @iCategId, '_bx_timeline_option_chars_display_max', 'digit', 'GreaterThan', 'a:1:{s:3:"min";i:150;}', '_bx_timeline_option_err_chars_display_max', '', 8);


-- PRIVACY 
INSERT INTO `sys_objects_privacy` (`object`, `module`, `action`, `title`, `default_group`, `table`, `table_field_id`, `table_field_author`, `override_class_name`, `override_class_file`) VALUES
('bx_timeline_privacy_view', 'bx_timeline', 'view', '_bx_timeline_privacy_view', '3', 'bx_timeline_events', 'id', '', 'BxTimelinePrivacy', 'modules/boonex/timeline/classes/BxTimelinePrivacy.php');


-- ACL
INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_timeline', 'post', NULL, '_bx_timeline_acl_action_post', '', 1, 3);
SET @iIdActionPost = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_timeline', 'delete', NULL, '_bx_timeline_acl_action_delete', '', 1, 3);
SET @iIdActionDelete = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_timeline', 'vote', NULL, '_bx_timeline_acl_action_vote', '', 1, 0);
SET @iIdActionVote = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_timeline', 'repost', NULL, '_bx_timeline_acl_action_repost', '', 1, 3);
SET @iIdActionRepost = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_timeline', 'send', NULL, '_bx_timeline_acl_action_send', '', 1, 3);
SET @iIdActionSend = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_timeline', 'pin', NULL, '_bx_timeline_acl_action_pin', '', 1, 3);
SET @iIdActionPin = LAST_INSERT_ID();

SET @iUnauthenticated = 1;
SET @iAccount = 2;
SET @iStandard = 3;
SET @iUnconfirmed = 4;
SET @iPending = 5;
SET @iSuspended = 6;
SET @iModerator = 7;
SET @iAdministrator = 8;
SET @iPremium = 9;

INSERT INTO `sys_acl_matrix` (`IDLevel`, `IDAction`) VALUES

-- post
(@iStandard, @iIdActionPost),
(@iModerator, @iIdActionPost),
(@iAdministrator, @iIdActionPost),
(@iPremium, @iIdActionPost),

-- delete
(@iModerator, @iIdActionDelete),
(@iAdministrator, @iIdActionDelete),

-- vote
(@iStandard, @iIdActionVote),
(@iModerator, @iIdActionVote),
(@iAdministrator, @iIdActionVote),
(@iPremium, @iIdActionVote),

-- repost
(@iStandard, @iIdActionRepost),
(@iModerator, @iIdActionRepost),
(@iAdministrator, @iIdActionRepost),
(@iPremium, @iIdActionRepost),

-- send
(@iStandard, @iIdActionSend),
(@iModerator, @iIdActionSend),
(@iAdministrator, @iIdActionSend),
(@iPremium, @iIdActionSend),

-- pin
(@iModerator, @iIdActionPin),
(@iAdministrator, @iIdActionPin);


-- ALERTS
INSERT INTO `sys_alerts_handlers`(`name`, `class`, `file`, `service_call`) VALUES 
('bx_timeline', 'BxTimelineResponse', 'modules/boonex/timeline/classes/BxTimelineResponse.php', '');
SET @iHandler := LAST_INSERT_ID();

INSERT INTO `sys_alerts` (`unit`, `action`, `handler_id`) VALUES
('profile', 'delete', @iHandler);


-- COMMENTS
INSERT INTO `sys_objects_cmts` (`Name`, `Module`, `Table`, `CharsPostMin`, `CharsPostMax`, `CharsDisplayMax`, `Nl2br`, `PerView`, `PerViewReplies`, `BrowseType`, `IsBrowseSwitch`, `PostFormPosition`, `NumberOfLevels`, `IsDisplaySwitch`, `IsRatable`, `ViewingThreshold`, `IsOn`, `RootStylePrefix`, `BaseUrl`, `ObjectVote`, `TriggerTable`, `TriggerFieldId`, `TriggerFieldAuthor`, `TriggerFieldTitle`, `TriggerFieldComments`, `ClassName`, `ClassFile`) VALUES
('bx_timeline', 'bx_timeline', 'bx_timeline_comments', 1, 5000, 1000, 1, 5, 3, 'tail', 1, 'bottom', 1, 1, 1, -3, 1, 'cmt', 'page.php?i=timeline-item&id={object_id}', '', 'bx_timeline_events', 'id', 'object_id', 'title', 'comments', 'BxTimelineCmts', 'modules/boonex/timeline/classes/BxTimelineCmts.php');


-- VIEWS
INSERT INTO `sys_objects_view` (`name`, `table_track`, `period`, `is_on`, `trigger_table`, `trigger_field_id`, `trigger_field_author`, `trigger_field_count`, `class_name`, `class_file`) VALUES 
('bx_timeline', 'bx_timeline_views_track', '86400', '1', 'bx_timeline_events', 'id', 'object_id', 'views', '', '');


-- VOTES
INSERT INTO `sys_objects_vote`(`Name`, `TableMain`, `TableTrack`, `PostTimeout`, `MinValue`, `MaxValue`, `IsUndo`, `IsOn`, `TriggerTable`, `TriggerFieldId`, `TriggerFieldAuthor`, `TriggerFieldRate`, `TriggerFieldRateCount`, `ClassName`, `ClassFile`) VALUES 
('bx_timeline', 'bx_timeline_votes', 'bx_timeline_votes_track', '604800', '1', '1', '0', '1', 'bx_timeline_events', 'id', 'object_id', 'rate', 'votes', 'BxTimelineVote', 'modules/boonex/timeline/classes/BxTimelineVote.php');


-- REPORTS
INSERT INTO `sys_objects_report` (`name`, `table_main`, `table_track`, `is_on`, `base_url`, `trigger_table`, `trigger_field_id`, `trigger_field_author`, `trigger_field_count`, `class_name`, `class_file`) VALUES 
('bx_timeline', 'bx_timeline_reports', 'bx_timeline_reports_track', '1', 'page.php?i=timeline-item&id={object_id}', 'bx_timeline_events', 'id', 'owner_id', 'reports',  'BxTimelineReport', 'modules/boonex/timeline/classes/BxTimelineReport.php');


-- SEARCH
SET @iSearchOrder = (SELECT IFNULL(MAX(`Order`), 0) FROM `sys_objects_search`);
INSERT INTO `sys_objects_search` (`ObjectName`, `Title`, `Order`, `ClassName`, `ClassPath`) VALUES
('bx_timeline', '_bx_timeline', @iSearchOrder + 1, 'BxTimelineSearchResult', 'modules/boonex/timeline/classes/BxTimelineSearchResult.php'),
('bx_timeline_cmts', '_bx_timeline_cmts', @iSearchOrder + 2, 'BxTimelineCmtsSearchResult', 'modules/boonex/timeline/classes/BxTimelineCmtsSearchResult.php');


-- METATAGS
INSERT INTO `sys_objects_metatags` (`object`, `table_keywords`, `table_locations`, `table_mentions`, `override_class_name`, `override_class_file`) VALUES
('bx_timeline', 'bx_timeline_meta_keywords', 'bx_timeline_meta_locations', '', '', '');


-- EMAIL TEMPLATES
INSERT INTO `sys_email_templates` (`Module`, `NameSystem`, `Name`, `Subject`, `Body`) VALUES 
('bx_timeline', '_bx_timeline_et_txt_name_send', 'bx_timeline_send', '_bx_timeline_et_txt_subject_send', '_bx_timeline_et_txt_body_send');


-- CONTENT INFO
INSERT INTO `sys_objects_content_info` (`name`, `title`, `alert_unit`, `alert_action_add`, `alert_action_update`, `alert_action_delete`, `class_name`, `class_file`) VALUES
('bx_timeline', '_bx_timeline', 'bx_timeline', 'post_common', '', 'delete', '', ''),
('bx_timeline_cmts', '_bx_timeline_cmts', 'bx_timeline', 'commentPost', 'commentUpdated', 'commentRemoved', 'BxDolContentInfoCmts', '');
