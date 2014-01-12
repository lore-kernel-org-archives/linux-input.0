From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input: uinput: add full absinfo support
Date: Sun, 12 Jan 2014 11:38:37 -0800
Message-ID: <20140112193837.GC13131@core.coreip.homeip.net>
References: <1387295334-1744-1-git-send-email-dh.herrmann@gmail.com>
 <1387295334-1744-2-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:41114 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaALTil (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jan 2014 14:38:41 -0500
Content-Disposition: inline
In-Reply-To: <1387295334-1744-2-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Antonio Ospite <ospite@studenti.unina.it>, linux-kernel@vger.kernel.org, input-tools@lists.freedesktop.org

On Tue, Dec 17, 2013 at 04:48:51PM +0100, David Herrmann wrote:
> +
> +struct uinput_user_dev2 {
> +	__u8 version;

It does not make sense to have version u8 since we going to have padding
(1 byte I believe) padding between name and id. 

> +	char name[UINPUT_MAX_NAME_SIZE];
> +	struct input_id id;
> +	__u32 ff_effects_max;
> +	struct input_absinfo abs[ABS_CNT];
> +};
> +
>  #endif /* _UAPI__UINPUT_H_ */
> -- 
> 1.8.5.1
> 

-- 
Dmitry
