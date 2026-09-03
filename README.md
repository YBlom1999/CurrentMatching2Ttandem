# Current matching in two-terminal solar cells
Multi-junction devices are a promising route of further increasing the conversion efficiency of solar cells, and thereby reducing the levelized cost of electricity for photovoltaic systems.
These so-called tandem devices come in three different architectures: two-terminal, three-terminal, and four-terminal.
Each architecture comes with its own advantages and disadvantages[1].
However, at the moment of writing (and to the best of my knowledge), two-terminal appear to be most promising.
This is largely due to their demonstrated record efficiencies and their similarity to conventional single-junction solar cells in both fabrication processes and module integration.

Two-terminal tandems, however, come with one major design constraint: current matching.
Because the subcells are connected in series, the same current needs to flow in the top and bottom cell at all times.
This means that the tandem cell should be designed in such a way that the performance is maximized when both cells operate at the same current.
This design requirement is often interpreted as the requirement that both cells should have generate the same photocurrent.
Various optical studies focus on the absorbed current in both subcells and aim to maximize the lowest value of absorbed current.
Although this is a good general approach, it is important to realize that matching current absorptions is only an approximation of the actual design requirement: Matching the maximum power point current of both cells.

When both subcells have sufficiently large fill factors (FF, all definitions are provided below), the maximum power point current ($J_{mpp}$) is approximately equal to the photogenerated current ($J_{ph}$). In this case, matching $J_{ph}$ is sufficient to achieve current matching. However, this approximation breaks down when the fill factor of one of the subcells is significantly reduced.

The figure below shows the (sub-) IV curves of the tandem cell with various shunt resistances ($R_{shunt}$) in the top cell. 
In each plot, the maximum power point of both the individual subcells and the complete tandem device is indicated by dashed lines.
For large values of $R_{shunt}$, the subcells have similar fill factors, and the device is effectively current matched when the photogenerated currents are equal. As $R_{shunt}$ decreases, however, the fill factor of the affected subcell deteriorates, causing its $J_{mpp}$ to decrease as well. 
Although the two subcells may still generate nearly identical photogenerated currents, the device is no longer truly current matched.
This becomes evident from the large difference between the tandem maximum power point current and the maximum power point currents of the individual subcells.

![Illustration of IV curves](Figures/IVcurves.png)

Recognizing that the design objective should be to match $J_{mpp}$ rather than $J_{ph}$ can lead to improved tandem-cell designs.
The figure below shows the effect of the top-cell bandgap energy on the current densities and output power, again for different values of $R_{shunt}$ in the top cell.
The red curve shows the output power of the tandem cell, and the vertical red line indicates the $P_{mpp}$.
In the top figures, the blue lines show the $J_{ph}$ of the top and bottom cell, which the blue vertical line showing when they match.
The bottom figures show (in red) the $J_{mpp}$ for both cells, with the blue vertical line showing an identical $J_{mpp}$.
As can be seen, the optimum bandgap predicted by matching $J_{mpp}$ corresponds much more closely to the bandgap that maximizes the tandem output power than the optimum predicted by matching $J_{ph}$. 
This demonstrates that $J_{mpp}$ is a more relevant metric for tandem-cell optimization, particularly when non-ideal cell properties, such as low shunt resistance, affect the subcell fill factors.
![Optimization of bandgap energy](Figures/EgOptimization.png)

The GUI in this repository can be used to recreate these figures, and explore for yourself how a tandem cell can be optimized.
Also the role of the air mass (that influences the irradiance spectrum) can be visualized.
Feel free to play around with the GUI, try different tandem cell and have fun!

With kind regards,
Youri Blom

## IV curve definitions
* $J$: The current density of the solar cell (this can take arbitrary values).
* $V(J)$: The voltage of a solar cell needed to produce a certain current density.
* $J_{sc}$: The short-circuit current; the current at which the voltage is 0.
* $V_{oc}$: The open-circuit voltage; the voltage at which the current is 0 (i.e. $V_{oc} = V(0)$);
* $P_{mpp}$: The maximum power point power; the highest output power that can be produced by the solar cell ($\max(V(J)\cdot J$)
* $J_{mpp}$: The maximum power point current density; the current at which the power ($V(J)\cdot J$) is maximum.
* $V_{mpp}$: The maximum power point voltage; the voltage at which the power is maximum ($V(J_{mpp}$).
* $FF$: The fill factor; a metric to indicate to which extend the JV curve can fill the square of $J_{sc}$ by $V_{oc}$ (written as $\frac{P_{mpp}}{J_{sc}\cdot V_{oc}}$
* $J_{ph}$: The photo-generated current density; the total amount of electron-hole pairs that is generated (i.e. $q \cdot \int EQE(\lambda) \cdot \phi(\lambda)d\lambda$).

## References
[1] Y. Blom, W. Suprayogi, M. Ruben Vogt, O. Isabella, and R. Santbergen, *Comparison on Module Performance and Degradation Robustness of Two-, Three-, and Four-Terminal Perovskite Silicon Configurations Under Realistic Operating Conditions*, Progress in Photovoltaics: Research and Applications 34, **6** (2026): 653–666, https://doi.org/10.1002/pip.70066.
