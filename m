From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v2] Input: ALPS - Fix ALPS touchpad detection
Date: Thu, 16 Feb 2012 08:32:10 -0600
Message-ID: <20120216143210.GA30486@ubuntu-macmini>
References: <4F3D009B.8080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52992 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab2BPOcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Feb 2012 09:32:15 -0500
Content-Disposition: inline
In-Reply-To: <4F3D009B.8080506@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Akio Idehara <zbe64533@gmail.com>
Cc: dmitry.torokhov@gmail.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, inux-kernel@vger.kernel.org

On Thu, Feb 16, 2012 at 10:11:55PM +0900, Akio Idehara wrote:
> ALPS touchpad detection fails if some buttons of ALPS are pressed.
> The reason is that the "E6" query response byte is different from
> what is expected.
> This was tested on a Toshiba Portege R500.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Akio Idehara <zbe64533@gmail.com>

This version is working fine for me. Thanks!

Tested-by: Seth Forshee <seth.forshee@canonical.com>
