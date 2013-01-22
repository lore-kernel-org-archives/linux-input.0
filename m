From: Doug Anderson <dianders@chromium.org>
Subject: Re: [v3,1/1] Input: add driver for Cypress APA I2C Trackpad
Date: Tue, 22 Jan 2013 09:57:54 -0800
Message-ID: <CAD=FV=UORUek34jfH+7mT8o3jDGoaPJkSM5J+BxMCjvtdLY5sw@mail.gmail.com>
References: <1354922656-13506-2-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:50514 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab3AVR57 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jan 2013 12:57:59 -0500
Received: by mail-la0-f44.google.com with SMTP id eb20so6723498lab.17
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2013 09:57:57 -0800 (PST)
Received: by mail-lb0-f169.google.com with SMTP id m4so4257485lbo.14
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2013 09:57:54 -0800 (PST)
In-Reply-To: <1354922656-13506-2-git-send-email-bleung@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: Jean Delvare <khali@linux-fr.org>, dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, Olof Johansson <olofj@chromium.org>, dudl@cypress.com

Benson,

On Fri, Dec 7, 2012 at 3:24 PM, Benson Leung <bleung@chromium.org> wrote:
> This patch introduces a driver for Cypress All Points Addressable
> I2C Trackpad, including the ones in 2012 Samsung Chromebooks.

I tried this patch out on my ARM Chromebook running a kernel based on 3.8-rc1
(it has a bunch of other local patches making their way upstream as well).

This patch worked just fine to get the trackpad working.  :)


> This device is compatible with MT protocol type B, providing identifiable
> contacts.
>
> Signed-off-by: Dudley Du <dudl@cypress.com>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Benson Leung <bleung@chromium.org>

Tested-by: Doug Anderson <dianders@chromium.org>
