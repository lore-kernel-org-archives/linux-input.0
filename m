From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 5/7] Input: ALPS - Add support for protocol versions 3
 and 4
Date: Sun, 30 Oct 2011 11:37:39 -0400
Message-ID: <4EAD6F43.2060306@canonical.com>
References: <1319663681-11244-1-git-send-email-seth.forshee@canonical.com> <1319663681-11244-6-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58175 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934146Ab1J3Phn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Oct 2011 11:37:43 -0400
In-Reply-To: <1319663681-11244-6-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@cvml.unipv.it>, Henrik Rydberg <rydberg@euromail.se>, Andrew Skalski <askalski@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/26/2011 05:14 PM, Seth Forshee wrote:
> This patch adds support for two ALPS touchpad protocols not
> supported currently by the driver, which I am arbitrarily naming
> version 3 and version 4. Support is single-touch only at this time,
> although both protocols are capable of limited multitouch support.
> 
> Thanks to Andrew Skalski, who did the initial reverse-engineering
> of the v3 protocol.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

The general architecture of the code looks good to me, and it has been
tested on many devices.

Acked-by: Chase Douglas <chase.douglas@canonical.com>
