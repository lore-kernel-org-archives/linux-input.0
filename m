From: <Jekyll_Lai@wistron.com>
Subject: RE: [PATCH] input: Add new button type
Date: Tue, 11 Jan 2011 10:17:19 +0800
Message-ID: <1DF7C3A7A8BDD14A84C44324F1BEB10002D4E0AB@WHQBEMAIL1.whq.wistron>
References: <20110110140131.11536.46959.stgit@bob.linux.org.uk> <20110110191916.GA30413@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twtpemsw2.wistron.com.tw ([220.128.88.32]:4837 "EHLO
	twtpemsw2.wistron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab1AKC2Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 21:28:16 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20110110191916.GA30413@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk
Cc: x86@kernel.org, linux-input@vger.kernel.org

> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> On Mon, Jan 10, 2011 at 02:01:32PM +0000, Alan Cox wrote:
> > From: Jekyll Lai <jekyll.lai@gmail.com>
> >
> > This patch added a new switch event, SW_ROTATE_LOCK, which is used
on one
> > of the Moorestown platforms.
> 
> Could we get a bit more explanation (preferably right in input.h) as
to
> what exactly this switch conveys to userspace? I guess it disables
> portrait->landscape screen transition on the phone?
> 
> Thanks.
> 
Your guess is exactly right; this event would be a flag to disable
rotate function, like portrait->landscape.

Jekyll
