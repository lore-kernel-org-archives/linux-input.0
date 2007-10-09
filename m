From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Handling transition into suspend through keyboard driver
Date: Tue, 9 Oct 2007 14:39:38 -0400
Message-ID: <d120d5000710091139t1af3bb64scce55d5005cc32f6@mail.gmail.com>
References: <20071008002510.d3ce4591.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071008002510.d3ce4591.Kristoffer.ericson@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input-list <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hi Kristoffer,

On 10/8/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> Greetings,
>
> Dmitry, Im implementing suspend for hp7xx currently. I've added EV_PWR to bitflags and linked so POWER_KEY gets reported correctly.
> Is this the correct approach?
>

Yes, it is. Keyboard drivers sghoudl just emit proper events and we expect
userspace to react on those properly. Look at corgi and spitz drivers.

-- 
Dmitry
