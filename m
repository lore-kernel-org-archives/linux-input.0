From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Polled input device: Add closing indication
Date: Mon, 12 Oct 2009 01:54:42 -0700
Message-ID: <200910120154.42432.dmitry.torokhov@gmail.com>
References: <1255334981-24118-1-git-send-email-samu.p.onkalo@nokia.com> <1255334981-24118-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:21707 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbZJLIzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 04:55:54 -0400
Received: by qw-out-2122.google.com with SMTP id 9so509798qwb.37
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2009 01:54:46 -0700 (PDT)
In-Reply-To: <1255334981-24118-2-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-input@vger.kernel.org

Hi Samu,

On Monday 12 October 2009 01:09:41 am Samu Onkalo wrote:
> When closing polled input device, call optional closing method
> to make it possible to turn off the HW.

What about open? How do you re-enable the device if it was closed and
then reopened?

-- 
Dmitry
