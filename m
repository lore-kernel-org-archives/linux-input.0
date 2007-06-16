From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Exporting EV_SW SW_LID events from thinkpad-acpi to input layer
Date: Sat, 16 Jun 2007 12:00:51 -0400
Message-ID: <200706161200.52863.dtor@insightbb.com>
References: <20070616144411.GA2127@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070616144411.GA2127@khazad-dum.debian.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On Saturday 16 June 2007 10:44, Henrique de Moraes Holschuh wrote:
> thinkpad-acpi can now be made to export EV_SW SW_LID events to the input
> layer.
> 
> However, most (all?) thinkpads will also generate ACPI notifications to
> \_SB.LID, on LID changes, i.e. this would duplicate an ACPI LID event, and I
> undertand ACPI is already moving to provide those over an input device by
> itself.
> 
> Given that situation, is it desireable for thinkpad-acpi to export EV_SW
> SW_LID events by itself (possibly duplicating an event that the ACPI layer
> will also issue)?  Or should I just ignore the lid events, and leave them
> for the ACPI layer to deal with?
> 

I would just rely on ACPI button driver to deliver EV_SW/SW_LID events.
After all there is only one lid switch on the box so having 2 input
devices rep[orting it is counter-intuitive.
 
-- 
Dmitry
