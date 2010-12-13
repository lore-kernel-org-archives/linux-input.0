From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: mt: Interface and MT_TOOL documentation updates
Date: Tue, 14 Dec 2010 00:25:26 +0100
Message-ID: <4D06AB66.8090909@euromail.se>
References: <1292001842-5000-1-git-send-email-rydberg@euromail.se> <4D065BDE.5020107@canonical.com> <4D068E3C.8080100@euromail.se> <4D06A60D.7010409@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:41225 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076Ab0LMX3P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 18:29:15 -0500
In-Reply-To: <4D06A60D.7010409@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>> The envelope contacts serve as a way to detect a small area of fingers or a

>> large area of fingers. There is nothing inherently problematic with having one
>> or three or more such contacts.
> 
> Then I'm more confused :).
> 
> I see one problem: devices that report two touch points, (X1, Y1) and
> (X2, Y2), but in reality the touches could be at (X1, Y2) and (X2, Y1)
> instead. Using a rectangle helps resolve this issue for panning and
> pinching, though not for rotation.


If panning and pinching and rotation could all be recovered properly, then the
individual contacts could actually have been reconstructed properly in the first
place. This is the whole point - there is not enough information available for
rotation to be recovered properly.

Thanks.
Henrik
