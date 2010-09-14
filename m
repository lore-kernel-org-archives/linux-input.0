From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: Wacom Bamboo Pen & Touch almost works now
Date: Tue, 14 Sep 2010 18:08:02 -0500
Message-ID: <15BF0950-4F6A-4D13-A84C-F3EF664D8F46@cnpbagwell.com>
References: <20100914171747.1e2f64d1@katamari>
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58804 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab0INXII convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 19:08:08 -0400
Received: by yxp4 with SMTP id 4so2525003yxp.19
        for <linux-input@vger.kernel.org>; Tue, 14 Sep 2010 16:08:07 -0700 (PDT)
In-Reply-To: <20100914171747.1e2f64d1@katamari>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, "<linux-input@vger.kernel.org>" <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>



On Sep 14, 2010, at 4:17 PM, Chuck Ebbert <cebbert@redhat.com> wrote:

> After I apply the nine patches for Bamboo support from the input git
> repo, only the pen works on the pen & touch. The light goes brighter
> when I touch the pad or press the buttons, but nothing else happens.
> Oh, and if I touch the pad while the display is in DPMS mode, the
> backlight comes on but that's all.

These patches present a more typical touchpad interface that xf86-input-wacom does not understand. Easiest choice is to rename xorg.conf.d/50-wacom.conf to 40-wacom.conf so the touchpad gets handled by xf86-input-synaptic and pen by xf86-input-wacom.  

I've got some draft patches submitted to linuxwacom-dev list to allow touchpad to also be handled by xf86-input-wacom though. 

Chris 