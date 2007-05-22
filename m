From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: wistron_btns: x86_64 support for key mappings?
Date: Tue, 22 May 2007 15:17:26 -0400
Message-ID: <d120d5000705221217j283f8545mb98770819ed13d00@mail.gmail.com>
References: <f2vdp9$cvp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <f2vdp9$cvp$1@sea.gmane.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Carlos Corbacho <cathectic@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Carlos,

On 5/22/07, Carlos Corbacho <cathectic@gmail.com> wrote:
> Would it be possible and acceptable to tweak the wistron_btns driver to be
> at least partially useful to x86_64 users?
>
> e.g. Strip out the BIOS calls on x86_64 and just leave the key mappings
> (such as through ifdef's or whatever method is the best for this case).
>
> (I would be happy to produce such a patch to do so, I just wanted some
> thoughts first).
>

Well, the main concern is how woudl you detect button presses without
BIOS calls?

-- 
Dmitry
