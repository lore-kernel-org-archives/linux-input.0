From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Tue, 13 Sep 2011 10:19:49 +0200
Message-ID: <CAPHpN5NMpiwBz9LNLKrn=eqMxCCZYtWRvcXjmqtHP1WERGvmLg@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com> <20110913080911.GA4986@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f52.google.com ([209.85.212.52]:62609 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab1IMIUJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:20:09 -0400
Received: by vws16 with SMTP id 16so618354vws.11
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 01:20:09 -0700 (PDT)
In-Reply-To: <20110913080911.GA4986@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com

Hi,

On Tue, Sep 13, 2011 at 10:09 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> The question is then what behavior should be assigned to
> a large tablet without an embedded screen. It should have POINTER set
> for sure, but should it also have DIRECT set?

Any large tablet without an embedded screen can be used in the 2 different ways:
1. The projection on top of it so it becomes a direct device.
(this case is also used when you project 3d 120hz on top of multitouch
devices: iMuts)

2. Simple indirect device, even if it's large:
http://10gui.com/video/

i
