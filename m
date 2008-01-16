From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.24-rc6] ads7846:  simplify support of external vREF
	(and ads7843)
Date: Wed, 16 Jan 2008 10:09:10 -0500
Message-ID: <20080116100717.ZZRA012@mailhub.coreip.homeip.net>
References: <200801051410.19925.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:43216 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbYAPPJQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 10:09:16 -0500
Received: by wx-out-0506.google.com with SMTP id h31so111192wxd.4
        for <linux-input@vger.kernel.org>; Wed, 16 Jan 2008 07:09:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200801051410.19925.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org

Hi David,

On Sat, Jan 05, 2008 at 02:10:19PM -0800, David Brownell wrote:
> This updates the ads7846 driver to handle external vREF (required
> on boards using ads7843 chips) without module parameters, and also
> removes a needless variable with its associated bogus gcc warning.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 

Is there any concern about people already using this module parameter
in the field? Should it still be present to allow users to override
platform default?

-- 
Dmitry
