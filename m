From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] input: signedness bug in cma3000_thread_irq()
Date: Wed, 14 Dec 2011 21:35:22 -0500
Message-ID: <ECD4A42B-AC97-417B-99CA-3856B5DAFAC6@gmail.com>
References: <1323672566-16738-1-git-send-email-xi.wang@gmail.com> <12775.1323916035@turing-police.cc.vt.edu>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40581 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab1LOCf1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 21:35:27 -0500
In-Reply-To: <12775.1323916035@turing-police.cc.vt.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Dec 14, 2011, at 9:27 PM, Valdis.Kletnieks@vt.edu wrote:
> That will fix the signed/unsigned issue.  However, was there a reason
> the field was an 8-bit-wide to begin with?

Which field?  The ->read() function pointer?

- xi
