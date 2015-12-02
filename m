From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/6] Input: Update vmmouse.c to use the common VMW_PORT
 macros
Date: Tue, 1 Dec 2015 16:01:00 -0800
Message-ID: <20151202000100.GA5363@kroah.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
 <1449008332-9394-1-git-send-email-syeh@vmware.com>
 <1449008332-9394-3-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59395 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbbLBABB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 19:01:01 -0500
Content-Disposition: inline
In-Reply-To: <1449008332-9394-3-git-send-email-syeh@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: x86@kernel.org, pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-input@vger.kernel.org

On Tue, Dec 01, 2015 at 02:18:49PM -0800, Sinclair Yeh wrote:
> v2:
> Instead of replacing existing VMMOUSE defines, only modify enough
> to use the new VMW_PORT define.
> 
> v3:
> Use updated VMWARE_PORT() which requires hypervisor magic as an added
> parameter

Why are these here and not below the --- line?

And no changelog text at all?  Not acceptable :(

greg k-h
