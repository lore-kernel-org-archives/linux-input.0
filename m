From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] input: remove BKL from uinput open function
Date: Sat, 30 Jan 2010 07:41:20 +0100
Message-ID: <201001300741.20954.arnd@arndb.de>
References: <1264800197-29523-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60628 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0A3HCl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 02:02:41 -0500
In-Reply-To: <1264800197-29523-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 29 January 2010, Thadeu Lima de Souza Cascardo wrote:
> Commit 8702965848ed4bee27486a3e3d2ae34ebba6dd83 has push down the BKL
> into uinput open function. However, there's nothing that needs locking
> in there.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

The change looks good, but the same driver also uses the BKL in the
default_llseek function. It would be nice to get rid of that in the
same patch, e.g. by adding a ".llseek = generic_file_llseek," line
in the file_operations, or making it call nonseekable_open() if the
driver does not require seek to do anything.

	Arnd
