From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3 1/3] cap11xx: make driver generic for variant support
Date: Sat, 27 Sep 2014 20:21:38 +0200
Message-ID: <54270032.5010204@zonque.org>
References: <1411622662-16581-1-git-send-email-mranostay@gmail.com> <1411622662-16581-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:44983 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbaI0SVm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Sep 2014 14:21:42 -0400
In-Reply-To: <1411622662-16581-2-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>, galak@codeaurora.org, dmitry.torokhov@gmail.com, zonque@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org

On 09/25/2014 07:24 AM, Matt Ranostay wrote:
> cap1106 driver can support much more one device make the driver
> generic for support of similiar parts.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  .../devicetree/bindings/input/cap1106.txt          |  53 ----
>  .../devicetree/bindings/input/cap11xx.txt          |  54 ++++
>  drivers/input/keyboard/Kconfig                     |   8 +-
>  drivers/input/keyboard/Makefile                    |   2 +-
>  drivers/input/keyboard/cap1106.c                   | 341 ---------------------
>  drivers/input/keyboard/cap11xx.c                   | 340 ++++++++++++++++++++
>  6 files changed, 399 insertions(+), 399 deletions(-)

As I've said, such a patch is really a whole lot more readable if you
use the -M switch for git format-patch to detect renames.

Other than that, the series now looks good to me. I can't test it,
however, as I don't have access to the hardware anymore.

  Reviewed-by: Daniel Mack <daniel@zonque.org>



Thanks,
Daniel

