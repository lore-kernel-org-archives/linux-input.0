From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 3/4] input: more i8042-reset quirks for MSI Wind-clone netbooks
Date: Fri, 7 Aug 2009 09:56:43 -0700
Message-ID: <20090807172652.41901526EA5@mailhub.coreip.homeip.net>
References: <200908062304.n76N4Dqw002622@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:8003 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbZHGQ4t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2009 12:56:49 -0400
Received: by rv-out-0506.google.com with SMTP id f6so481256rvb.1
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2009 09:56:48 -0700 (PDT)
In-Reply-To: <200908062304.n76N4Dqw002622@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, yan.i.li@intel.com, alan@lxorguk.ukuu.org.uk, mjg59@srcf.ucam.org

On Thursday 06 August 2009 16:04:13 akpm@linux-foundation.org wrote:
> From: Yan Li <yan.i.li@intel.com>
>
> When testing Moblin on various netbooks, we've got reports that many MSI
> Wind clones need the i8042 reset quirks for the keyboard and/or touchpad's
> proper function.

Already in mainline, please drop.

-- 
Dmitry
