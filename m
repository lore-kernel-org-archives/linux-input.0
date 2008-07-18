From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] sh_keysc: Remove request_mem_region() and release_mem_region()
Date: Fri, 18 Jul 2008 20:55:04 +0900
Message-ID: <aec7e5c30807180455o75108dc2gb7a22b95d18d251@mail.gmail.com>
References: <20080718083836.29015.8503.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:16522 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbYGRLzH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jul 2008 07:55:07 -0400
Received: by qw-out-2122.google.com with SMTP id 3so105870qwe.37
        for <linux-input@vger.kernel.org>; Fri, 18 Jul 2008 04:55:04 -0700 (PDT)
In-Reply-To: <20080718083836.29015.8503.sendpatchset@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tetsuya Mukawa <mukawa@igel.co.jp>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, dmitry.torokhov@gmail.com, lethal@linux-sh.org, akpm@linux-foundation.org

On Fri, Jul 18, 2008 at 5:38 PM, Tetsuya Mukawa <mukawa@igel.co.jp> wrote:
> Remove request_mem_region() and release_mem_region() from sh_keysc driver.
> Those functions can find resource conflict, but it is already checked in
> platform_device_add().

Yes, the request_mem_region() and release_mem_region() calls are redundant.

> Signed-off-by: Tetsuya Mukawa <mukawa@igel.co.jp>
Signed-off-by: Magnus Damm <damm@igel.co.jp>

Thanks for the patch! =)

/ magnus
