From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: strict_strtoul takes unsigned long
Date: Tue, 23 Dec 2008 04:12:24 -0500
Message-ID: <20081223091224.GB14302@anvil.corenet.prv>
References: <1228176260.5482.12.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:27452 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbYLWJMb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Dec 2008 04:12:31 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1508246qwe.37
        for <linux-input@vger.kernel.org>; Tue, 23 Dec 2008 01:12:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1228176260.5482.12.camel@brick>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input <linux-input@vger.kernel.org>, Joe Rouvier <joe@rouvier.org>

On Mon, Dec 01, 2008 at 04:04:20PM -0800, Harvey Harrison wrote:
> Fix sparse warning introduced by:
> commit 160f1fef7e52e974489b3c70fbd4e094c06965c2 Input: convert drivers to use strict_strtoul()
> 

Applied, thank you Harvey.

-- 
Dmitry
