From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Version 2: [PATCH 2/3] ACPI: Send switch event on dock events
Date: Mon, 9 Jun 2008 02:48:23 -0700
Message-ID: <20080609024823.a8387821.akpm@linux-foundation.org>
References: <20080528130621.GA32646@srcf.ucam.org>
	<20080528132152.GB32646@srcf.ucam.org>
	<20080529082202.GD16444@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080529082202.GD16444@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: linux-input@vger.kernel.org

On Thu, 29 May 2008 09:22:02 +0100 Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> Send a switch event on docking for consistency with docks that don't 
> present as a separate device.

It oopses: http://userweb.kernel.org/~akpm/p6096540.jpg

http://userweb.kernel.org/~akpm/config-t61p.txt
