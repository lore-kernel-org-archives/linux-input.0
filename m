From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH 1/2] Input: Use accessor for MT events
Date: Fri, 13 Jan 2012 09:58:57 +0100
Message-ID: <4F0FF251.70509@gmail.com>
References: <1326396065-2448-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46058 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab2AMI7B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jan 2012 03:59:01 -0500
In-Reply-To: <1326396065-2448-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/12/2012 08:21 PM, Henrik Rydberg wrote:
> Add an accessor function for the actual MT event types, and use
> it everywhere.

Just to double check, it's only used in two places as you have below?
Your comment made me think it's used all over, and maybe you forgot to
git add files.

If everything is correct,

Reviewed-by: Chase Douglas <chase.douglas@canonical.com>
