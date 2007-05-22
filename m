From: Carlos Corbacho <cathectic@gmail.com>
Subject: Re: wistron_btns: x86_64 support for key mappings?
Date: Tue, 22 May 2007 21:59:21 +0100
Message-ID: <f2vlik$bp5$1@sea.gmane.org>
References: <f2vdp9$cvp$1@sea.gmane.org> <d120d5000705221217j283f8545mb98770819ed13d00@mail.gmail.com>
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

Dmitry Torokhov wrote:

> Well, the main concern is how woudl you detect button presses without
> BIOS calls?

I see what you mean now - I had been looking at some of the other BIOS
calling functions in there at the top of the code which are not absolutely
necessary; but I see now stripping out all the BIOS calls is unavoidable
because of the polling required.

I suppose the only alternative then would probably be to port the code to
x86_64 assembly at some distant point in the future.

Sorry about the noise.

-Carlos
