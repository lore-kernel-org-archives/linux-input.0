From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Lenovo Yoga 13 touchpad regression
Date: Tue, 07 May 2013 16:02:40 -0700
Message-ID: <51898810.4090301@zytor.com>
References: <5188905A.4020703@zytor.com> <CAJiQ=7DDpCUTXasoo8qbrv-g87Ak7NFvKXSn6+cfhKai06yG_A@mail.gmail.com> <51894B6F.9040108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33047 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab3EGXCr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 May 2013 19:02:47 -0400
In-Reply-To: <51894B6F.9040108@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/07/2013 11:43 AM, H. Peter Anvin wrote:
> 
> What is really bizarre is that some time today the touchpad
> spontaneously started to work.  However, after a reboot it no longer
> worked again.  This is on 3.8.11.  The keycode spewage continued, however.
> 

OK, "spontaneously" seems to mean "after going in and out of suspend to
RAM".

	-hpa


