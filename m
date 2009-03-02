From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Notification when a new device is added or removed
Date: Mon, 02 Mar 2009 15:41:49 -0800
Message-ID: <49AC6EBD.4090206@manoweb.com>
References: <49A8BEF7.9060602@manoweb.com> <20090228183917.ZZRA012@mailhub.coreip.homeip.net> <49A9F9BD.2090604@manoweb.com> <20090301022212.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59343 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbZCBXl5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 18:41:57 -0500
In-Reply-To: <20090301022212.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:

> Hmm, it turns out poll is completely busted. The patch below should
> help.

Testing shows that patch solves the problem.

bye!
as

