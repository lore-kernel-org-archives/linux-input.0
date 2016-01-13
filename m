From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: uinput on headless system ...
Date: Wed, 13 Jan 2016 14:21:51 -0800
Message-ID: <20160113222151.GE39593@dtor-ws>
References: <56965CFB.3020401@icid.cu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36495 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcAMWVy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 17:21:54 -0500
Received: by mail-pa0-f45.google.com with SMTP id yy13so272514894pab.3
        for <linux-input@vger.kernel.org>; Wed, 13 Jan 2016 14:21:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56965CFB.3020401@icid.cu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roberto Alejandro Espi Munoz <raespi@icid.cu>
Cc: linux-input@vger.kernel.org

Hi Roberto,

On Wed, Jan 13, 2016 at 09:19:39AM -0500, Roberto Alejandro Espi Munoz wrote:
> Hello ... I've been searching around the web for a specific mailing
> list for the uinput driver but couldn't find any.  I managed to
> create an example app that injects keyboard events to the running
> linux kernel succesfully when I have a keyboard attached to the
> computer.  However if I run it on a keyboardless machine, like a
> standalone motherboard, the uinput device fails to open.

uinput driver does not depend on presence of a physical keyboard. I'd
start looking whether uinput module is enabled on your headless box and
if it is a module verify that it is loaded.

Thanks.

-- 
Dmitry
