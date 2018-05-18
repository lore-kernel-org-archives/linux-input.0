From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx
 vibrator documentation
Date: Fri, 18 May 2018 11:54:08 -0500
Message-ID: <20180518165408.GA31804@rob-hp-laptop>
References: <44b17778d8f0bf897a316a39516ba2cafecf43c9.1525928437.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44b17778d8f0bf897a316a39516ba2cafecf43c9.1525928437.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xiaotong.lu@spreadtrum.com
List-Id: linux-input@vger.kernel.org

On Thu, May 10, 2018 at 01:08:33PM +0800, Baolin Wang wrote:
> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> 
> This patch adds the binding documentation for Spreadtrum SC27xx series
> vibrator device.
> 
> Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v3:
>  - Change compatible string to explicit Soc name.
>  - Add parent MFD node.
> 
> Changes since v2:
>  - No updates.
> 
> Changes since v1:
>   - No updates.
> ---
>  .../bindings/input/sprd,sc27xx-vibra.txt           |   23 ++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt

Reviewed-by: Rob Herring <robh@kernel.org>
