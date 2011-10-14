From: Terry Lambert <tlambert@chromium.org>
Subject: Re: [PATCH] Driver for Primax keyboards violating USB HID spec
Date: Fri, 14 Oct 2011 14:55:34 -0700
Message-ID: <CAA_E9NH3eD+PaAc0jBDj6EnuU7sHbFyhKobhbCXPW7z6nBJwBg@mail.gmail.com>
References: <1318548517-5289-1-git-send-email-tlambert@chromium.org>
	<alpine.LNX.2.00.1110140134200.14768@pobox.suse.cz>
	<CAA_E9NHi4mS+J5VrxS915S3TD-157D=hMG7b-PMT2c1RYvnwVQ@mail.gmail.com>
	<alpine.LNX.2.00.1110141127240.14768@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:27058 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab1JNVzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 17:55:37 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p9ELtaVm003972
	for <linux-input@vger.kernel.org>; Fri, 14 Oct 2011 14:55:36 -0700
Received: from ggnk3 (ggnk3.prod.google.com [10.218.97.67])
	by wpaz21.hot.corp.google.com with ESMTP id p9ELsXt3009092
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 14 Oct 2011 14:55:35 -0700
Received: by ggnk3 with SMTP id k3so2420759ggn.11
        for <linux-input@vger.kernel.org>; Fri, 14 Oct 2011 14:55:35 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1110141127240.14768@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

I have no problem doing that; I'll rework the patch.

Thanks!
-- Terry

On Fri, Oct 14, 2011 at 2:30 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>
> On Thu, 13 Oct 2011, Terry Lambert wrote:
>
> > Hi Jiri; thanks for looking so promptly!
> >
> > The routine right now just caches the hi->input for later look up
> > during the raw input report, which I suppose could be done inline o=
n
> > each report with a couple function calls.
>
> Well yes, but even in px_raw_event() the px_device *px is only
> initialized, but never used. So I'd just remove the whole px_device t=
hing
> altogether, I don't think it's needed.
>
> > I don't have one of the folding keyboards people are complaining ab=
out
> > not being able to use for Android tablets on hand, or the unhappy D=
ell
> > Inspiron laptop, both of which use the controller =A0=A0That's to e=
xplain
> > why the remapping code and the product ID for them are missing from
> > this patch.
>
> I see.
>
> I'd like to ask you though to only submit patches containing code tha=
t is
> actually used. Whenever the remapping part is needed for some other
> keyboard, we'll just add it at the very time it's needed.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
