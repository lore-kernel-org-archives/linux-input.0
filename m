From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: Rewriting wheels HID descriptor for complete functionality
Date: Wed, 01 Dec 2010 22:32:51 +0300
Message-ID: <4CF6A2E3.70702@gmail.com>
References: <e0bdb04c6bf793ed464934fd4f8b663e.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58374 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab0LATc4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 14:32:56 -0500
Received: by ewy5 with SMTP id 5so3788894ewy.19
        for <linux-input@vger.kernel.org>; Wed, 01 Dec 2010 11:32:55 -0800 (PST)
In-Reply-To: <e0bdb04c6bf793ed464934fd4f8b663e.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 12/01/2010 09:23 PM, simon@mungewell.org wrote:
> I am considering re-writing the HID descriptor to expose these separate
> values as 'proper' axis, as they would provide both better resolution and
> better functionality (ie. left foot braking).
>
> Q1. Is this an acceptable thing to do?
>
> Q2. In the case where there is significant change to the HID descriptor,
> is it OK to just re-write the whole block (rather than patch/swap a couple
> of bytes)?
When I asked a similar question on linux-usb, nobody answered, but nobody
complained when I submitted patches with 8 full report descriptors either.
They were accepted by Jiri Kosina.

I could also recommend using my tool for (de-)composing HID report
descriptors:
http://digimend.sourceforge.net/#proj-hidrd

Sincerely,
Nick
