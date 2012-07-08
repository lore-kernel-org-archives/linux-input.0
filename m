From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v2] Input: synaptics - add sysfs access to firmware
 ID & board ID
Date: Sat, 7 Jul 2012 18:16:21 -0700
Message-ID: <20120708011621.GG19007@core.coreip.homeip.net>
References: <1341392837-19115-1-git-send-email-djkurtz@chromium.org>
 <1341392837-19115-2-git-send-email-djkurtz@chromium.org>
 <20120704130848.GA316@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46118 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab2GHBQ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jul 2012 21:16:27 -0400
Content-Disposition: inline
In-Reply-To: <20120704130848.GA316@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 04, 2012 at 03:08:48PM +0200, Henrik Rydberg wrote:
> On Wed, Jul 04, 2012 at 05:07:17PM +0800, Daniel Kurtz wrote:
> > Allow userspace to query firmware ID and board ID, which are read and
> > cached during device initialization.
> > 
> > This information can be read, for instance, by a userspace feedback
> > reporting tool, to include this information in its reports.
> > 
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> >  drivers/input/mouse/synaptics.c |   41 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 41 insertions(+), 0 deletions(-)
> 
> Still reluctant here, but I am fine with whatever Dmitry thinks about it.

I do not think we need to have additional attributes - reporting
tools will collect kernel logs so since your previous change dumps the
data there that is all we need.

Thanks.

-- 
Dmitry
