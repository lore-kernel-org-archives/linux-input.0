From: Carlos Corbacho <cathectic@gmail.com>
Subject: wistron_btns: x86_64 support for key mappings?
Date: Tue, 22 May 2007 19:46:22 +0100
Message-ID: <f2vdp9$cvp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Would it be possible and acceptable to tweak the wistron_btns driver to be
at least partially useful to x86_64 users?

e.g. Strip out the BIOS calls on x86_64 and just leave the key mappings
(such as through ifdef's or whatever method is the best for this case).

(I would be happy to produce such a patch to do so, I just wanted some
thoughts first).

-Carlos
