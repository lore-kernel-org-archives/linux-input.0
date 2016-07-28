From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: USB vulnerabilities
Date: Thu, 28 Jul 2016 10:48:48 -0700
Message-ID: <20160728174848.GA16852@dtor-ws>
References: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35068 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161013AbcG1Rsw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 13:48:52 -0400
Received: by mail-pf0-f175.google.com with SMTP id x72so24158284pfd.2
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2016 10:48:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: roswest <roswest@cisco.com>
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>

Hi Rosie,

On Thu, Jul 28, 2016 at 12:23:09PM -0400, roswest wrote:
> 
> Dmitry,
> 
> Hi, I am an engineer at Cisco Systems, and this summer we tasked some
> interns with performing USB fuzzing. One of the interns, Anirudh Bagde,
> was able to crash the USB stack due to an error in the iforce module and
> discovered a buffer over-read in the usbtouchscreen module.  Please see
> the attachment for details.

Thank you for the report. Any chance Anirudh could provide patches to
fix these issues as well?

Thanks!

-- 
Dmitry
