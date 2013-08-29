From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Thu, 29 Aug 2013 13:03:13 +0300
Message-ID: <20130829100313.GG7393@intel.com>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12801 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab3H2J5p (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 05:57:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>, srinivas pandruvada <srinivas.pandruvada@intel.com>

On Wed, Aug 28, 2013 at 10:31:44PM +0200, Jiri Kosina wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> A HID device could send a malicious feature report that would cause the
> sensor-hub HID driver to read past the end of heap allocation, leaking
> kernel memory contents to the caller.
> 
> CVE-2013-2898
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
