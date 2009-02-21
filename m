From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch] hid: move tmff and zpff devices from ignore_list to blacklist
Date: Sat, 21 Feb 2009 09:55:41 +0200
Message-ID: <499FB37D.8020409@gmail.com>
References: <499692A1.6030303@gmail.com> <alpine.LNX.1.10.0902161203320.18110@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:38936 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbZBUH4A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Feb 2009 02:56:00 -0500
In-Reply-To: <alpine.LNX.1.10.0902161203320.18110@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Sat, 14 Feb 2009, Anssi Hannula wrote:
> 
>> The devices handled by hid-tmff and hid-zpff were added in the
>> hid_ignore_list[] instead of hid_blacklist[] in 
> 
> Good catch, thanks for cathing this overlook. I have applied your patch to 
> my tree.

Maybe this should also go to the stable 2.6.29 tree?

-- 
Anssi Hannula
