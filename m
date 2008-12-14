From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] Add support for Wacom W8001 penabled serial touchscreen
Date: Mon, 15 Dec 2008 01:00:26 +0800
Message-ID: <45a44e480812140900i1c7fdfa4odd1d217ad312e4c0@mail.gmail.com>
References: <12274510394135-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:6615 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbYLNRA3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Dec 2008 12:00:29 -0500
Received: by nf-out-0910.google.com with SMTP id d3so394553nfc.21
        for <linux-input@vger.kernel.org>; Sun, 14 Dec 2008 09:00:26 -0800 (PST)
In-Reply-To: <12274510394135-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sun, Nov 23, 2008 at 10:37 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Hi Dmitry, linux-input,
>
> Thanks for your previous feedback. I've made the improvements to drop the use
> of cmd mutex, expected packet, cleanup and report tilt events. Let me know
> your thoughts.
>
> Thanks,
> jaya
>

Hi Dmitry,

Was this patch okay?

Thanks,
jaya
