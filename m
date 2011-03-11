From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: enable i8042-level wakeup control
Date: Fri, 11 Mar 2011 00:31:29 -0800
Message-ID: <20110311083129.GG10807@core.coreip.homeip.net>
References: <20110210171607.D0D419D401D@zog.reactivated.net>
 <20110310203602.114944c0@debxo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54172 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1CKIbg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 03:31:36 -0500
Received: by ywj3 with SMTP id 3so1065428ywj.19
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2011 00:31:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110310203602.114944c0@debxo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: Daniel Drake <dsd@laptop.org>, linux-input@vger.kernel.org, rjw@sisk.pl

Hi Andres,

On Thu, Mar 10, 2011 at 08:36:02PM +0000, Andres Salomon wrote:
> I never saw any discussion on this, and it doesn't look like it's in
> any git trees (afaict). Dmitry, what are your thoughts on the patch?
> 

I must say I am very wary about this patch. I know that there are a few
boxes that will get very confused if we do not reset their
mice/touchpads to the bare PS/2 protocol and I also do not believe that
we can rely on devices keeping their protocol settings after s2r and
especially s2d even if they are marked as wakeup sources.

I understand that that may be the case with OLPC but not with other
boxes...

Thanks.

-- 
Dmitry
