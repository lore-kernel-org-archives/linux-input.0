From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] sony-laptop/thinkpad-acpi: fix build error
Date: Tue, 18 Sep 2007 16:23:30 -0300
Message-ID: <20070918192330.GD5655@khazad-dum.debian.net>
References: <20070917205434.GA22458@devil> <200709181249.14909.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200709181249.14909.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andreas Herrmann <aherrman@arcor.de>, Len Brown <len.brown@intel.com>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, 18 Sep 2007, Len Brown wrote:
> Unless you object, I'll just change this to "depends on" when i apply it.

IMHO either is fine, so consider this an Ack for either select or depend for
what concerns thinkpad-acpi.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
