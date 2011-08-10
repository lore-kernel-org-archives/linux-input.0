From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Wiimote userspace interface
Date: Wed, 10 Aug 2011 20:26:00 +0200
Message-ID: <201108102026.00717.oliver@neukum.org>
References: <CANq1E4S3VY_xxzcjuJDHJc57VPb_uiFrx1B3wR9Xnw5ddx6HJg@mail.gmail.com> <alpine.LNX.2.00.1108101359530.32288@pobox.suse.cz> <CANq1E4RuCqpnYEXUQNEaq_MLocqzyXNwXZGb+pYpO8otwxV4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:38410 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab1HJS3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 14:29:51 -0400
In-Reply-To: <CANq1E4RuCqpnYEXUQNEaq_MLocqzyXNwXZGb+pYpO8otwxV4qw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>

Am Mittwoch, 10. August 2011, 15:37:32 schrieb David Herrmann:
> On Wed, Aug 10, 2011 at 2:00 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> > On Wed, 10 Aug 2011, Jiri Kosina wrote:
> >
> >> Thanks a lot for your work on the driver, David.
> >
> > ... so I am now postponing the merge of the series you have sent, and
> > waiting for your respin, okay?
> 
> Yes, I will resend the patches with the new interface and probably
> include the extension-support with it as I have almost finished that.
> 
> Thanks for your hints and yeah, power-consumption was the only problem
> with this interface but I think I can implement some power-savings
> later if it turns out to be an issue.

It is much easier to do that at the beginning. Redesign is usually painful.

	Regards
		Oliver
