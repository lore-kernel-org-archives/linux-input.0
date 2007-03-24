From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Circular synaptics pads
Date: Sat, 24 Mar 2007 04:27:08 +0000
Message-ID: <20070324042708.GA14593@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

After looking through some dumps, I've come to the conclusion that bit 6 
of the extended capabilities field in Synaptics pads seems to be 
associated with the pad being circular. Does this sound broadly 
plausible, or is it more likely that that information would be in the 
model ID field? In any case, what would be the best way to export this 
information to userspace?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org
