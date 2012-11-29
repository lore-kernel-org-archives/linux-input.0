From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 01/11] HID: hid-input factorize hid_input allocation
Date: Thu, 29 Nov 2012 15:58:35 +0100
Message-ID: <CAN+gG=FO0K=i_WbvCZaaSiwz_yrGZuDXQ_fno3K+t3JOCombtQ@mail.gmail.com>
References: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
	<1353684694-5723-2-git-send-email-benjamin.tissoires@gmail.com>
	<alpine.LNX.2.00.1211291459490.25639@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50556 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab2K2O6h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 09:58:37 -0500
In-Reply-To: <alpine.LNX.2.00.1211291459490.25639@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 29, 2012 at 3:00 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 23 Nov 2012, Benjamin Tissoires wrote:
>
>> This just refactors the allocation of hid_input.
>> No semantic changes.
>
> As this is a generic cleanup, I am taking this one through
> for-3.8/upstream branch.

Thanks Jiri.
Sorry for not answering earlier, I was working on an other solution
for pen devices before speculating on the review of the other patches
:)

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
