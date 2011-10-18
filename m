From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3 6/7] input/cma3000_d0x: Unwind reverse order of init
Date: Tue, 18 Oct 2011 10:03:46 -0700
Message-ID: <201110181003.46805.dmitry.torokhov@gmail.com>
References: <1318952886-835-1-git-send-email-ricardo.ribalda@gmail.com> <201110180953.34156.dmitry.torokhov@gmail.com> <CAPybu_16xkTK1dn_NKzduxb6Q=fESyi6d0mDswkDqUMOtoPfcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59110 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab1JRRD4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 13:03:56 -0400
In-Reply-To: <CAPybu_16xkTK1dn_NKzduxb6Q=fESyi6d0mDswkDqUMOtoPfcg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, jic23@cam.ac.uk, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, October 18, 2011 09:57:24 AM Ricardo Ribalda Delgado wrote:
> Hello Dmitry
> 
>  You are right, and also could be a good idea to init the irq, only
> after the input device has been registered. Dont you think so?

Input core is constructed in such way that it is safe to call
input_report_*() and input_event() on properly allocated input device,
even if it has not been registered yet, the events will simply be
dropped.

So no, it is not necessary and doing so is quite often complicates
error handling in probe() routines.

Thanks.

-- 
Dmitry
