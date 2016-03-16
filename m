From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Wed, 16 Mar 2016 12:53:32 +0100
Message-ID: <CACRpkdZWzPDDLvvD1A=ioKwEfujRj_Xgv15QDyp+HD-=hW0eLQ@mail.gmail.com>
References: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
	<CACRpkdaE91ncWccG9_dsOiC40j9mFpm7A=S_mpeHmP-vjSVjMQ@mail.gmail.com>
	<56BE200F.5040602@synaptics.com>
	<20160303171138.GH22340@mail.corp.redhat.com>
	<20160311180521.GA13175@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33698 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbcCPLxd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 07:53:33 -0400
Received: by mail-oi0-f52.google.com with SMTP id d205so36378592oia.0
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2016 04:53:32 -0700 (PDT)
In-Reply-To: <20160311180521.GA13175@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

On Fri, Mar 11, 2016 at 7:05 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Mar 03, 2016 at 06:11:38PM +0100, Benjamin Tissoires wrote:

>> I'd like to see the series in 4.6, and we are getting closer of the
>> merge window. Could we get some of your time on this?
>
> I adjusted the binding on patch 5 (to read -x-mm and y-mm) and applied
> the first 9 leaving the HID out for now.

Thanks to everyone involved that we finally got this in upstream shape
after all these years!

Yours,
Linus Walleij
