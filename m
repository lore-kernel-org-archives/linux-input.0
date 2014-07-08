From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2 v2] lib: int_sqrt: add int64_sqrt routine
Date: Tue, 8 Jul 2014 15:12:38 -0700
Message-ID: <20140708221238.GB29203@core.coreip.homeip.net>
References: <1404390870-24062-1-git-send-email-21cnbao@gmail.com>
 <20140708145501.bf6efdebd4991fec5422d0a1@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60023 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbaGHWMn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jul 2014 18:12:43 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so7869706pde.38
        for <linux-input@vger.kernel.org>; Tue, 08 Jul 2014 15:12:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140708145501.bf6efdebd4991fec5422d0a1@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <21cnbao@gmail.com>, linux-input@vger.kernel.org, workgroup.linux@csr.com, Yibo Cai <yibo.cai@csr.com>, Peter Meerwald <pmeerw@pmeerw.net>, Barry Song <Baohua.Song@csr.com>

On Tue, Jul 08, 2014 at 02:55:01PM -0700, Andrew Morton wrote:
> On Thu,  3 Jul 2014 20:34:30 +0800 Barry Song <21cnbao@gmail.com> wrote:
> 
> > Get square root of a 64-bit digit on 32bit platforms. CSR SiRFSoC
> > touchscreen driver needs it.
> 
> Looks OK to me.  Can this be carried in whatever tree holds the "CSR
> SiRFSoC touchscreen driver"?

Yeah, I'll pick it up.

-- 
Dmitry
