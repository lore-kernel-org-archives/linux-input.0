From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC] Wiimote userspace interface
Date: Wed, 10 Aug 2011 15:37:32 +0200
Message-ID: <CANq1E4RuCqpnYEXUQNEaq_MLocqzyXNwXZGb+pYpO8otwxV4qw@mail.gmail.com>
References: <CANq1E4S3VY_xxzcjuJDHJc57VPb_uiFrx1B3wR9Xnw5ddx6HJg@mail.gmail.com>
	<20110803061744.GB23399@core.coreip.homeip.net>
	<CANq1E4QgF6i2UJQpaRDkOf-vwGH9vMfU9HfL8O8Rt38uup3qew@mail.gmail.com>
	<alpine.LNX.2.00.1108101355360.32288@pobox.suse.cz>
	<alpine.LNX.2.00.1108101359530.32288@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64720 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab1HJNhc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 09:37:32 -0400
Received: by vws1 with SMTP id 1so830903vws.19
        for <linux-input@vger.kernel.org>; Wed, 10 Aug 2011 06:37:32 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1108101359530.32288@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>, Oliver Neukum <oneukum@suse.de>

On Wed, Aug 10, 2011 at 2:00 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 10 Aug 2011, Jiri Kosina wrote:
>
>> Thanks a lot for your work on the driver, David.
>
> ... so I am now postponing the merge of the series you have sent, and
> waiting for your respin, okay?

Yes, I will resend the patches with the new interface and probably
include the extension-support with it as I have almost finished that.

Thanks for your hints and yeah, power-consumption was the only problem
with this interface but I think I can implement some power-savings
later if it turns out to be an issue.

> Thanks again,
>
> --
> Jiri Kosina
> SUSE Labs

Regards
David
