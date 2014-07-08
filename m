From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2 v2] lib: int_sqrt: add int64_sqrt routine
Date: Tue, 8 Jul 2014 14:55:01 -0700
Message-ID: <20140708145501.bf6efdebd4991fec5422d0a1@linux-foundation.org>
References: <1404390870-24062-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36616 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaGHVzD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jul 2014 17:55:03 -0400
In-Reply-To: <1404390870-24062-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, workgroup.linux@csr.com, Yibo Cai <yibo.cai@csr.com>, Peter Meerwald <pmeerw@pmeerw.net>, Barry Song <Baohua.Song@csr.com>

On Thu,  3 Jul 2014 20:34:30 +0800 Barry Song <21cnbao@gmail.com> wrote:

> Get square root of a 64-bit digit on 32bit platforms. CSR SiRFSoC
> touchscreen driver needs it.

Looks OK to me.  Can this be carried in whatever tree holds the "CSR
SiRFSoC touchscreen driver"?
