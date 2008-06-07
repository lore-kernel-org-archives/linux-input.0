From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: RESEND: [PATCH 3/3] Misc: Add HP WMI laptop extras driver
Date: Sat, 7 Jun 2008 11:00:02 +0100
Message-ID: <200806071100.03097.carlos@strangeworlds.co.uk>
References: <20080528132900.GC32646@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:37580 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbYFGKAF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jun 2008 06:00:05 -0400
In-Reply-To: <20080528132900.GC32646@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 28 May 2008 14:34:25 Matthew Garrett wrote:
> This driver adds support for reading and configuring certain information
> on modern HP laptops with WMI BIOS interfaces. It supports enabling and
> disabling the ambient light sensor, querying attached displays and hard
> drive temperature, sending events on docking and querying the state of
> the dock and toggling the state of the wifi, bluetooth and wwan hardware
> via rfkill. It also makes the little "(i)" button work on machines that
> send that via WMI rather than via the keyboard controller.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

For the ACPI-WMI bits:

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
