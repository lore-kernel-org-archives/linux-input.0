From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: HID: huion: Switch to generating report descriptor
Date: Mon, 11 Aug 2014 21:09:19 +0300
Message-ID: <53E906CF.9030306@gmail.com>
References: <20140731094012.GH30276@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:55666 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbaHKSJW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 14:09:22 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so4695913wiw.0
        for <linux-input@vger.kernel.org>; Mon, 11 Aug 2014 11:09:21 -0700 (PDT)
In-Reply-To: <20140731094012.GH30276@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

Hi Dan,

On 07/31/2014 12:40 PM, Dan Carpenter wrote:
> The patch f8dd5cb2c6d0: "HID: huion: Switch to generating report
> descriptor" from Jul 23, 2014, leads to the following static checker
> warning:
>
> 	drivers/hid/hid-huion.c:126 huion_tablet_enable()
> 	error: doing dma on the stack (buf)

Thanks a lot for notifying about the problem.
I just submitted two patches fixing this under subject "HID: huion: Fix "doing
dma on the stack"".

Sincerely,
Nick
