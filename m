From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Circular synaptics pads
Date: Sat, 24 Mar 2007 04:33:12 +0000
Message-ID: <20070324043312.GB14593@srcf.ucam.org>
References: <20070324042708.GA14593@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070324042708.GA14593@srcf.ucam.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Ah, ignore that - it is in fact defined in the model ID field (should 
have read the specs more closely first!) - if bits 0-3 equal 0x02, then 
the pad is oval rather than rectangular (which matches the dumps I have 
access to). So, the remaining question is how should this be exported to 
userspace? In terms of interpreting scrolling, it's helpful for the 
driver to know that the pad is circular.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
