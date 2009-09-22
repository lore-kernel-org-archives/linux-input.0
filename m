From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: atkbd - add forced release keys quirk for Samsung
	P560/P210
Date: Tue, 22 Sep 2009 11:46:03 -0700
Message-ID: <20090922184603.GC22639@core.coreip.homeip.net>
References: <1253642013.11485.8.camel@buzz-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:44598 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZIVSqJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 14:46:09 -0400
Received: by pzk28 with SMTP id 28so10256pzk.5
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 11:46:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1253642013.11485.8.camel@buzz-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Michael Brummer <jan.brummer@tabos.org>
Cc: linux-input@vger.kernel.org

Hi Jan-Michael,

On Tue, Sep 22, 2009 at 07:53:33PM +0200, Jan-Michael Brummer wrote:
> This patch fixes the key repeat issue with the Fn+F? keys on the
> Samsung P560 and P210 Notebook, so that the keys can used correctly,
> otherwise the keys repeat indefinitely.
> 
> Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>

Thank you for the patch, however I will not be accepting any more
patches adding the force-release quirks to atkbd, in .32 there will be a
way to adjust the bitmap through sysfs.

Thanks.

-- 
Dmitry
