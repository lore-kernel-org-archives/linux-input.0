From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] input: misc: Add driver for Intel Bay Trail GPIO
 buttons
Date: Wed, 26 Mar 2014 17:04:04 +0000
Message-ID: <20140326170404.47a6380a@alan.etchedpixels.co.uk>
References: <533259F7.3050908@linux.intel.com>
	<53325F30.4030006@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50594 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbaCZREQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Mar 2014 13:04:16 -0400
In-Reply-To: <53325F30.4030006@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Zhu, Lejun" <lejun.zhu@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 26 Mar 2014 13:01:36 +0800
"Zhu, Lejun" <lejun.zhu@linux.intel.com> wrote:

> This patch adds support for the GPIO buttons on some Intel Bay Trail
> tablets originally running Windows 8. The ACPI description of these
> buttons follows "Windows ACPI Design Guide for SoC Platforms".

I'm not sure calling it "Baytrail" is right here - it's in theory a
generic interface so probably should be named accordingly

Otherwise looks good to me.

Alan
