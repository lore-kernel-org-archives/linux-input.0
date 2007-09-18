From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop/thinkpad-acpi: fix build error
Date: Wed, 19 Sep 2007 08:04:48 +0900
Message-ID: <20070918230448.GA11154@inferi.kami.home>
References: <20070917205434.GA22458@devil> <200709181249.14909.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <200709181249.14909.lenb@kernel.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Len Brown <lenb@kernel.org>
Cc: Andreas Herrmann <aherrman@arcor.de>, Len Brown <len.brown@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, Sep 18, 2007 at 12:49:14PM -0400, Len Brown wrote:
> On Monday 17 September 2007 16:54, Andreas Herrmann wrote:
> > sony-laptop and thinkpad-acpi make use of input-core functions.
> > Hence you get link errors if those drivers are built but CONFIG_INPUT
> > is not set. Attached patch fixes this minor issue.
...
> Unless you object, I'll just change this to "depends on" when i apply it.

that is fine to me

cheers
-- 
mattia
:wq!
