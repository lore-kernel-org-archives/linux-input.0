From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] hid: move tmff and zpff devices from ignore_list to
 blacklist
Date: Mon, 16 Feb 2009 12:04:04 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902161203320.18110@jikos.suse.cz>
References: <499692A1.6030303@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43071 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbZBPLEG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2009 06:04:06 -0500
In-Reply-To: <499692A1.6030303@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, 14 Feb 2009, Anssi Hannula wrote:

> The devices handled by hid-tmff and hid-zpff were added in the
> hid_ignore_list[] instead of hid_blacklist[] in 

Good catch, thanks for cathing this overlook. I have applied your patch to 
my tree.

-- 
Jiri Kosina
SUSE Labs
