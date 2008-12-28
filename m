From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.28 thinks that my PS/2 mouse is a touchpad
Date: Sat, 27 Dec 2008 22:21:52 -0800
Message-ID: <20081227222152.fdb4bf23.akpm@linux-foundation.org>
References: <gj4r8h$okm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38877 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127AbYL1GVy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Dec 2008 01:21:54 -0500
In-Reply-To: <gj4r8h$okm$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 27 Dec 2008 14:06:29 +0500 "Alexander E. Patrakov" <patrakov@gmail.com> wrote:

> Linux-2.6.28, as compiled by Arch Linux developers, thinks that my PS/2 mouse (a cheap M-BT58 optical wheel mouse by Logitech) is actually a touchpad. This makes it unusable. Adding the "proto=imps" parameter to the psmouse module helps.
> 
> Dmesg output and config are attached.

(cc linux-input)
