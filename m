From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v4 0/3] input: appletouch: fixes for jagged/uneven cursor
 movement
Date: Sun, 23 Mar 2014 15:02:35 +0100
Message-ID: <532EE97B.1050805@bitmath.org>
References: <52D9DE7A.7040509@gmail.com> <5320EA03.2040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp10.one.com ([195.47.247.110]:56658 "EHLO csmtp10.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbaCWOJZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Mar 2014 10:09:25 -0400
In-Reply-To: <5320EA03.2040206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clinton Sprain <clintonsprain@gmail.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> input: appletouch: fixes for jagged/uneven cursor movement
> 
> The appletouch driver can make some touchpads feel insensitive, with movement that tends to jerk in steps. This is particularly evident when moving diagonally. There is also undesirable movement when additional fingers enter or leave the touchpad.
> 
> These patches address these issues by dialing back the fuzz setting, by implementing sensor data smoothing and by discarding movements that directly coincide with a change in the number of fingers detected on the touchpad.

Thanks Clinton, for resolving this long-standing nuisance. It all looks good to
me now.

Henrik

