From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/20] Input: atmel_mxt_ts - allow writing to object
 sysfs entry
Date: Tue, 20 Mar 2012 23:03:53 +0000
Message-ID: <20120320230353.5625540f@pyramind.ukuu.org.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
	<1331640263-18935-7-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37509 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab2CTXBo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 19:01:44 -0400
In-Reply-To: <1331640263-18935-7-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Tue, 13 Mar 2012 20:04:09 +0800
Daniel Kurtz <djkurtz@chromium.org> wrote:

> Userspace can write a 24-bit value (encoded as a 6 character hex string)
> to the 'object' sysfs entry to modify a single byte of the object table.
> The hex string encodes a 3 bytes, in the following format:

How is this locked against other users and updates of these table data ?

I don't see how all the objects and their pointers and size are
guaranteedto always be valid in all the users you have ?

