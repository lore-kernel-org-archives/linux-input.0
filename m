From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 12:22:43 +0200
Message-ID: <4C2877F3.8020003@euromail.se>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com> <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com> <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com> <4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com> <4C28689A.60701@euromail.se> <4C2872B2.1030405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:60669 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751862Ab0F1KWz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 06:22:55 -0400
In-Reply-To: <4C2872B2.1030405@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Joonyoung Shim wrote:
[...]
> Do you mean to report the coordinates of contact __remaining__? You told 
> me at first, "The position should be the position where the finger left
> the surface", so i am confusing.

The two comments do not apply to the same situation. The latter comment was made
in the context of a tracking-capable device which sends one last event for a
finger going away. Transformed to the stateless type A protocol, that results in
(touch = 0, x = last value, y = last value). The former comment was in the
general context of the type A protocol, which has no notion of anything going
away. After you lift a finger and look at the state, what you see is the
remaining set of fingers.

Thank you,
Henrik

